From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCHv2] Thermal: Fix synchronization issues in thermal_sys.c
Date: Thu, 27 Sep 2012 14:38:46 +0200
Message-ID: <CA+icZUWd0s4bo4ASnfryUvSNSk82d5f3-so1RghbOhqHH5UOaw@mail.gmail.com>
References: <1348727888-11196-1-git-send-email-durgadoss.r@intel.com>
	<CA+icZUXV21BqzAHwPy5gY_VHEws8hXZ8B=vESuPazpmOSQVHvA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CA+icZUXV21BqzAHwPy5gY_VHEws8hXZ8B=vESuPazpmOSQVHvA@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, dan.carpenter@oracle.com, hughd@google.com, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 27, 2012 at 10:01 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Thu, Sep 27, 2012 at 8:38 AM, Durgadoss R <durgadoss.r@intel.com> wrote:
>> This patch fixes the following mutex and NULL pointer
>> problems in thermal_sys.c:
>>  * mutex_unlock fix in update_temperature function
>>  * mutex_unlock fix in bind_cdev function
>>  * NULL check fix in bind_tz function
>>
>> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>> Reported-by: Hugh Dickins <hughd@google.com>
>> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
>> ---
>> v2:
>>  * Removed unnecessary NULL check in bind_cdev
>>  * Added 'Reported-by' tags for Sedat and Hugh
>>  drivers/thermal/thermal_sys.c |    7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
>> index 4f77d89..e1179d3 100644
>> --- a/drivers/thermal/thermal_sys.c
>> +++ b/drivers/thermal/thermal_sys.c
>> @@ -253,7 +253,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
>>
>>                 tzp = pos->tzp;
>>                 if (!tzp->tbp)
>> -                       return;
>> +                       continue;
>>
>>                 for (i = 0; i < tzp->num_tbps; i++) {
>>                         if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
>> @@ -289,7 +289,7 @@ static void bind_tz(struct thermal_zone_device *tz)
>>                 goto exit;
>>         }
>>
>> -       if (!tzp->tbp)
>> +       if (!tzp || !tzp->tbp)
>>                 goto exit;
>>
>>         list_for_each_entry(pos, &thermal_cdev_list, node) {
>> @@ -390,12 +390,13 @@ static void update_temperature(struct thermal_zone_device *tz)
>>         ret = tz->ops->get_temp(tz, &temp);
>>         if (ret) {
>>                 pr_warn("failed to read out thermal zone %d\n", tz->id);
>> -               return;
>> +               goto exit;
>>         }
>>
>>         tz->last_temperature = tz->temperature;
>>         tz->temperature = temp;
>>
>> +exit:
>>         mutex_unlock(&tz->lock);
>>  }
>>
>> --
>> 1.7.9.5
>>
>
> The v2 patch does *not* fix the issue here!
>
> [1] https://patchwork.kernel.org/patch/1511961/
>

I have re-tested with Linux-Next (next-20120927) plus thermal-next [1]
pulled in and see still the same call-trace!

Hugh or Dan can you confirm this works for you or not?
Thanks in advance.

[1] http://git.kernel.org/?p=linux/kernel/git/rzhang/linux.git;a=shortlog;h=refs/heads/next
[2] http://git.kernel.org/?p=linux/kernel/git/rzhang/linux.git;a=commitdiff;h=404b134156bd9d9bc506c0974a1254806e13db2c

>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-next" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
