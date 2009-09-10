From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [RESEND] [PATCH 1/3] ACPI: battery: Fix CONFIG_ACPI_SYSFS_POWER=n
Date: Thu, 10 Sep 2009 12:11:13 +0100
Message-ID: <9b2b86520909100411o6dc850a5mc80792285411aff3@mail.gmail.com>
References: <4A4A219C.2020802@tuffmail.co.uk>
	 <1252339562.28499.13.camel@maxim-laptop>
	 <4AA7E438.4070905@tuffmail.co.uk>
	 <1252531271.4174.5.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cd80a04b5900473374228
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35670 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbZIJLLM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 07:11:12 -0400
Received: by bwz19 with SMTP id 19so1064663bwz.37
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2009 04:11:14 -0700 (PDT)
In-Reply-To: <1252531271.4174.5.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

--0015175cd80a04b5900473374228
Content-Type: text/plain; charset=ISO-8859-1

On 9/9/09, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> On Wed, 2009-09-09 at 18:22 +0100, Alan Jenkins wrote:
>> Maxim Levitsky wrote:
>> > Hi,
>> >
>> > So this is newer version of this patchset.
>> > When this will be merged?
>> >
>> >
>> > Last patch doesn't apply, seems that parts of yours patch were applied.
>> > I applied it manually.
>> >
>> > Will soon test.
>> >
>> >
>> > Best regards,
>> > 	Maxim Levitsky
>> >
>>
>> I will submit "To: len" next time round.
>>
>> You're right, it no longer applies cleanly to acpi-test.  ["patch" is
>> happy to apply it and warn about "fuzz", but git-am is more strict.  It
>> doesn't look like there's a real conflict.]
> I applied it on top of both vanilla and linux-next. Here it really
> doesn't apply (with or without 'fuzz')
>
>>
>> I look forward to your results.  Please tell me the diff you end up with
>> for the last patch and what tree you applied it on top of.  That way, if
>> I add "Tested-by: Maxim..." I can be certain we're talking about the
>> same patch :-).
>>
>> Thanks!
>> Alan
>
> I did that few days ago (applied patch manually, without much thinking)
>
> Unfortunately, resulting kernel oopses if battery is present, and
> otherwise, if I plug batter later on, many battery statistics are
> missing (probably some locks are held)
>
> I will soon investigate this issue, more deeply.
>
> Best regards,
> Maxim Levitsky

I've applied the patches from the mailing list, initially on -rc8
using git-am, then rebased them onto acpi-test without conflicts.  I
don't have GIT hosting, so here's a git bundle.  If you're still
having problems, you should be able to get an _exact_ copy of my tree
with

$ git fetch alan.bundle battery-check:battery-check
$ git checkout battery-check

so long as you have the acpi-test commit I based it on.

Thanks
Alan

--0015175cd80a04b5900473374228
Content-Type: application/octet-stream; name="alan.bundle"
Content-Disposition: attachment; filename="alan.bundle"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

IyB2MiBnaXQgYnVuZGxlCi05MGNlYmUzNTZjZGEwZjY4MDk0YmI3NzJlZGM3YzM2ZGMyMzBhN2Ew
IE1lcmdlIGJyYW5jaCAnYWNwaWNhJyBpbnRvIHRlc3QKZDNhNmI0ZTYxMTQ2YTA3NmUzZmRlN2Nj
NzMyNjQxYmFjYzY3ZTMzNyByZWZzL2hlYWRzL2JhdHRlcnktY2hlY2sKClBBQ0sAAAACAAAAD5dE
eJyVU9tq3DAQfddXDPvU0uxie9e7dighIVB6SaCQQB+LbI3XqmXJ6LKO/74je7sJ9KUFW6DxzDlz
zoy9RYR9XmCWiKzY7rI0Lw6HbZGmWbYvMM0P+b4p6zJJsNizgVvUHsq6EmWOhyStG9yKBKuyLspd
0uS8rHiz3RXNrsz2GePBt8bCneIavqLupHbwkdNt/Wu53frQND2XalObTehuIM12++0hoxc+JGmS
sNr0vfQe/xMlz/IDHekZhd3df/9yDRWPSNM1WDxKF0EHM6L96cIwqAlcqASeZI2AJ9QwtnScS0Ab
D4NFR/oZ+4Y4SH0E30oH5xJuTdACFHoHwaF1A6dop81IadzDiNDyE+X9gWQVn64WJtlQDloEgiOi
NmJLCnugQvoCvemJeAPwHBnpGSMk1RKMiaWXPoWVFAVh0F2BMxCFg2tNUIKCMyRVo1Ibxj7RbPCF
94PCq0VLj5zMPWqiW8/WrHuu+ZEAR6kURDFcKTproxt5DJY6ZRWSMGmChYYAV+bVtBlidZZ3iZJu
GKkL7Ac/gdHMeW59GDbw7rnlunPgDTzyF9nDA3nrXTfNyIOR2l9sN8G/Jw3Pr77RVLkjdqqeJ2XJ
7chrSPqlR/LwB85CamMt1l5NbLDmJMWSvDoPeUXWeyur4MmbsZV1u1hg0QerYZWslv14I4xRFxZ7
c0JBLJ/vHmaVXFFbYgJvp7l3A3WLdbeIuHDMYOyvbmcEGQcU5z/jzhtwHmhcyorgO+B6Apq7k2Sn
aSI5efMkjxrF2jTNuqKl//cfiN3fx3R8wQmeaDiyMyfXyYmq3JvrraNF3wi8Yb8BisZ6AJ4geJyV
kM1OwzAQhO9+ir0BgkaJWycNQghUOIA4IPEA1cbepCaOHfmnkLfHFRy49rLSaGe+XU30RFALaup1
KXjLy5ZKIVHRRoiab6u+ltR1qhftRjRsRk82Qr0hqYjXLcl12663TZ4NbyVyVZEQSFJUW961DFM8
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
6YKa9fT5jea4gP1vD4wVM6c=
--0015175cd80a04b5900473374228--
