export class Status {
  static readonly Draft = "D"
  static readonly Submitted = "S"
  static readonly Rejected = "R"
  static readonly Approved = "A"
  static readonly Published = "P"
  static readonly Expired = "E";
  static readonly RequestToEdit = "T"
  static readonly Active = "A";
  static readonly Inactive = "I";
  static readonly Deativated = "D";
  static readonly Deleted = "D";
}

export function canUpdate(s?: string): boolean {
  return s!== Status.Approved && s!== Status.Expired
}
export function canApprove(s?: string): boolean{
  return s === Status.Submitted
}
export function canReject(s?: string): boolean{
  return s === Status.Submitted || s === Status.Approved
}
