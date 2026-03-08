export function slugify(title: string, uuid: string, wordLimit: number = 10, maxLength: number = 60): string {
  const words = title
    .toLowerCase()
    .normalize("NFD")                     // NEW: split base char + accent
    .replace(/[\u0300-\u036f]/g, "")      // NEW: remove accents (áê → ae)
    .replace(/đ/g, "d")                   // NEW: Vietnamese special case
    .replace(/-/g, " ")                   // treat "-" as space
    .replace(/[^a-z0-9\s]/g, "")          // keep ASCII only
    .trim()
    .split(/\s+/)
    .slice(0, wordLimit)

  let slug = words.join("-")

  if (slug.length > maxLength) {
    slug = slug.substring(0, maxLength).replace(/-+$/, "")
  }

  return slug.length === 0 ? uuid : `${slug}-${uuid}`
}
