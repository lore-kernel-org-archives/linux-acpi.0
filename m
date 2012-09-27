From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCHv2] Thermal: Fix synchronization issues in thermal_sys.c
Date: Thu, 27 Sep 2012 16:05:55 +0200
Message-ID: <CA+icZUXo+w8G1ugG+m3YBE-LT7Qb6_Mbo2ijRqRXP1HXLTohGQ@mail.gmail.com>
References: <1348727888-11196-1-git-send-email-durgadoss.r@intel.com>
	<CA+icZUXV21BqzAHwPy5gY_VHEws8hXZ8B=vESuPazpmOSQVHvA@mail.gmail.com>
	<CA+icZUWd0s4bo4ASnfryUvSNSk82d5f3-so1RghbOhqHH5UOaw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d040711731eae8604caaf707f
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54966 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab2I0OF7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Sep 2012 10:05:59 -0400
In-Reply-To: <CA+icZUWd0s4bo4ASnfryUvSNSk82d5f3-so1RghbOhqHH5UOaw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, dan.carpenter@oracle.com, hughd@google.com, linux-next@vger.kernel.org

--f46d040711731eae8604caaf707f
Content-Type: text/plain; charset=UTF-8

On Thu, Sep 27, 2012 at 2:38 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Thu, Sep 27, 2012 at 10:01 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> On Thu, Sep 27, 2012 at 8:38 AM, Durgadoss R <durgadoss.r@intel.com> wrote:
>>> This patch fixes the following mutex and NULL pointer
>>> problems in thermal_sys.c:
>>>  * mutex_unlock fix in update_temperature function
>>>  * mutex_unlock fix in bind_cdev function
>>>  * NULL check fix in bind_tz function
>>>
>>> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>>> Reported-by: Hugh Dickins <hughd@google.com>
>>> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
>>> ---
>>> v2:
>>>  * Removed unnecessary NULL check in bind_cdev
>>>  * Added 'Reported-by' tags for Sedat and Hugh
>>>  drivers/thermal/thermal_sys.c |    7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
>>> index 4f77d89..e1179d3 100644
>>> --- a/drivers/thermal/thermal_sys.c
>>> +++ b/drivers/thermal/thermal_sys.c
>>> @@ -253,7 +253,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
>>>
>>>                 tzp = pos->tzp;
>>>                 if (!tzp->tbp)
>>> -                       return;
>>> +                       continue;
>>>
>>>                 for (i = 0; i < tzp->num_tbps; i++) {
>>>                         if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
>>> @@ -289,7 +289,7 @@ static void bind_tz(struct thermal_zone_device *tz)
>>>                 goto exit;
>>>         }
>>>
>>> -       if (!tzp->tbp)
>>> +       if (!tzp || !tzp->tbp)
>>>                 goto exit;
>>>
>>>         list_for_each_entry(pos, &thermal_cdev_list, node) {
>>> @@ -390,12 +390,13 @@ static void update_temperature(struct thermal_zone_device *tz)
>>>         ret = tz->ops->get_temp(tz, &temp);
>>>         if (ret) {
>>>                 pr_warn("failed to read out thermal zone %d\n", tz->id);
>>> -               return;
>>> +               goto exit;
>>>         }
>>>
>>>         tz->last_temperature = tz->temperature;
>>>         tz->temperature = temp;
>>>
>>> +exit:
>>>         mutex_unlock(&tz->lock);
>>>  }
>>>
>>> --
>>> 1.7.9.5
>>>
>>
>> The v2 patch does *not* fix the issue here!
>>
>> [1] https://patchwork.kernel.org/patch/1511961/
>>
>
> I have re-tested with Linux-Next (next-20120927) plus thermal-next [1]
> pulled in and see still the same call-trace!
>
> Hugh or Dan can you confirm this works for you or not?
> Thanks in advance.
>
> [1] http://git.kernel.org/?p=linux/kernel/git/rzhang/linux.git;a=shortlog;h=refs/heads/next
> [2] http://git.kernel.org/?p=linux/kernel/git/rzhang/linux.git;a=commitdiff;h=404b134156bd9d9bc506c0974a1254806e13db2c
>

With the attached fixup/followup patch, I can boot into my system!
But, as said yesterday... working within X, Firefox is a pain in the a**.

- Sedat -

>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-next" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--f46d040711731eae8604caaf707f
Content-Type: application/octet-stream;
	name="0001-Thermal-Fixup-to-commit-404b134156bd-Fix-synchroniza.patch"
Content-Disposition: attachment;
	filename="0001-Thermal-Fixup-to-commit-404b134156bd-Fix-synchroniza.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h7lxq3j20

RnJvbSAyNmI4ODYxNzUwNWFjYjU5ZDkzODg0MTk5ZGU5YzZhOTRkMzA2ZWMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDI3IFNlcCAyMDEyIDE0OjQzOjI0ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gVGhl
cm1hbDogRml4dXAgdG8gY29tbWl0IDQwNGIxMzQxNTZiZCAoIkZpeCBzeW5jaHJvbml6YXRpb24K
IGlzc3VlcyBpbiB0aGVybWFsX3N5cy5jIikKCgpTaWduZWQtb2ZmLWJ5OiBTZWRhdCBEaWxlayA8
c2VkYXQuZGlsZWtAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX3N5cy5j
IHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfc3lzLmMgYi9kcml2ZXJzL3Ro
ZXJtYWwvdGhlcm1hbF9zeXMuYwppbmRleCBlMTE3OWQzLi44NDg1NTNkIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9zeXMuYworKysgYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1h
bF9zeXMuYwpAQCAtMjUyLDcgKzI1Miw3IEBAIHN0YXRpYyB2b2lkIGJpbmRfY2RldihzdHJ1Y3Qg
dGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldikKIAkJfQogCiAJCXR6cCA9IHBvcy0+dHpwOwot
CQlpZiAoIXR6cC0+dGJwKQorCQlpZiAoIXR6cCB8fCAhdHpwLT50YnApCiAJCQljb250aW51ZTsK
IAogCQlmb3IgKGkgPSAwOyBpIDwgdHpwLT5udW1fdGJwczsgaSsrKSB7Ci0tIAoxLjcuOS41Cgo=
--f46d040711731eae8604caaf707f--
