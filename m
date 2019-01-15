From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] acpi: fix a potential inconsistency caused by double-fetch
Date: Tue, 15 Jan 2019 20:05:35 +0100
Message-ID: <CAJZ5v0gDQWeWhuq0-4=H6NxGO99Q9o5heT3NDf0DCtseanO5AA@mail.gmail.com>
References: <20181225214633.69973-1-kjlu@umn.edu> <20190109081423.10781-1-kjlu@umn.edu>
 <CAJZ5v0iR9WrW6GafCmKR8oHagg3vqGMKEuXmJ58Ewp_cOB5uew@mail.gmail.com> <CAK8KejpGipqLpR93=ZnRze9FU7q5ZhJrGQV33czZwuxqSs0AyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8KejpGipqLpR93=ZnRze9FU7q5ZhJrGQV33czZwuxqSs0AyQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Aditya Pakki <pakki001@umn.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 15, 2019 at 7:05 AM Kangjie Lu <kjlu@umn.edu> wrote:
>
>
>
> On Mon, Jan 14, 2019 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, Jan 9, 2019 at 9:14 AM Kangjie Lu <kjlu@umn.edu> wrote:
>> >
>> > "user_buf->length" is in user space, and copied in twice. The second
>> > copy is after it passes the security check. If a user program races to
>> > change user_buf->length in user space, the data fetched in the second
>> > copy may invalidate the security check. The fix avoids the double-fetch
>> > issue by using the value passing the security check.
>>
>> AFAICS the patch really does two things: it avoids the issue described
>> above and avoids using the (redundant) 'table' local variable on the
>> stack.  Arguably, you could fix the issue without getting rid of the
>> redundant variable.
>>
>> >
>> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> > ---
>> >  drivers/acpi/custom_method.c | 10 ++++++----
>> >  1 file changed, 6 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
>> > index 4451877f83b6..f10ee0519033 100644
>> > --- a/drivers/acpi/custom_method.c
>> > +++ b/drivers/acpi/custom_method.c
>> > @@ -26,17 +26,16 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>> >         static u32 max_size;
>> >         static u32 uncopied_bytes;
>> >
>> > -       struct acpi_table_header table;
>> >         acpi_status status;
>> >
>> >         if (!(*ppos)) {
>> >                 /* parse the table header to get the table length */
>> >                 if (count <= sizeof(struct acpi_table_header))
>> >                         return -EINVAL;
>> > -               if (copy_from_user(&table, user_buf,
>> > -                                  sizeof(struct acpi_table_header)))
>> > +               if (get_user(max_size,
>> > +                                       &((struct acpi_table_header *)user_buf)->length))
>> >                         return -EFAULT;
>> > -               uncopied_bytes = max_size = table.length;
>> > +               uncopied_bytes = max_size;
>> >                 buf = kzalloc(max_size, GFP_KERNEL);
>> >                 if (!buf)
>> >                         return -ENOMEM;
>> > @@ -57,6 +56,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>> >                 return -EFAULT;
>> >         }
>> >
>> > +       /* Ensure table length is not changed in the second copy */
>> > +       ((struct acpi_table_header *)(buf + (*ppos)))->length = max_size;
>>
>> Why don't you return -EFAULT if max_size is different from ->length?
>> Surely, the table should not be used at all in that case.
>
>
> We could do either, but I didn't see one is clearly better than the other.

As I said, why would you use any inconsistent data instead of
returning an error?

>>
>> Moreover, wouldn't it be even better to compare the entire header with
>> the one read previously and return -EFAULT if they don't match?
>
>
> If other fields are not critical and thus not checked, we don't have to compare
> the entire header for better performance reasons.

If you really care about consistency, performance doesn't matter that much.

Thanks,
Rafael
