From: roel kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH ?] ACPI: pr->id is unsigned
Date: Tue, 16 Sep 2008 22:48:19 -0400
Message-ID: <48D06FF3.6010406@gmail.com>
References: <48CF0CA4.3090701@gmail.com> <128370.1221510405@turing-police.cc.vt.edu> <200809161045.35078.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:41501 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbYIPUsZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Sep 2008 16:48:25 -0400
Received: by ik-out-1112.google.com with SMTP id c30so2570674ika.5
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2008 13:48:22 -0700 (PDT)
In-Reply-To: <200809161045.35078.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Valdis.Kletnieks@vt.edu, linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> On Monday 15 September 2008 22:26:45 Valdis.Kletnieks@vt.edu wrote:
>> On Mon, 15 Sep 2008 21:32:20 EDT, roel kluin said:
>>> since pr->id is unsigned, shouldn't something like
>>> the patch below be applied?
>>>
>>> +	BUG_ON((pr->id >= nr_cpu_ids) || ((unsigned long)pr->id < 0));
>> Under what conditions will the clause "(unsigned long)pr->id < 0)" be true,
>> and when will it be false?  What will any sane optimizing compiler do?

ah, yes, remove it, I wasn't thinking. :-/

>> And *sometimes*, the *real* bug is that pr->id should be a signed quantity,
>> not an unsigned one, and the cast is just papering over the issue.
>>
>> In other words, the original line is almost certainly buggy.  However, this
>> isn't the right fix.  Somebody who actually understands the code will have
>> to decide what *should* be happening here (that's beyond my understanding
>> of that code)...

Thanks for correcting me, I should have verified that.

A prior mail, http://lkml.org/lkml/2008/9/9/136
brought me on a wrong line of thought:

[Quote (with ret as an unsigned long)]
if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)

This and similar ones are not wrong. The -constant is converted
to unsigned (which is a well-defined operation) after which an >=u
(greater-or-equal unsigned) is performed.
[End Quote]

> Just removing "pr->id < 0" condition should be the right fix.
> 
> For such an easy patch in the ACPI subsystem it's enough to only post to
> the linux-acpi mailing list, no need to bother the whole world.

Ok, removed the rest of the world :-)

> Thanks for finding this, do you mind to repost a new version?
> 
>     Thomas
> 
pr->id is unsigned

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index ee68ac5..9f203d3 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -667,7 +667,7 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 		return 0;
 	}
 
-	BUG_ON((pr->id >= nr_cpu_ids) || (pr->id < 0));
+	BUG_ON(pr->id >= nr_cpu_ids);
 
 	/*
 	 * Buggy BIOS check
