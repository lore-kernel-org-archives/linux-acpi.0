From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH][v2] ACPI: Do not report _OSI("Darwin") when
 acpi_osi=!Darwin provided
Date: Mon, 1 Feb 2016 11:31:16 +0200
Message-ID: <CAHp75Vc-8H_Kzxux7mFZLFjQhhNfzxGfo64xDhE9ot339Uy=GQ@mail.gmail.com>
References: <1454293612-13161-1-git-send-email-yu.c.chen@intel.com>
	<CAHp75VdaNFVA10X_N-URqmKAv3upOF2zT083T0tiN1=DnLqNbA@mail.gmail.com>
	<36DF59CE26D8EE47B0655C516E9CE640286C0A85@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35919 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbcBAJbR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2016 04:31:17 -0500
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE640286C0A85@shsmsx102.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>, "Zhang, Rui" <rui.zhang@intel.com>

On Mon, Feb 1, 2016 at 11:13 AM, Chen, Yu C <yu.c.chen@intel.com> wrote:

>> > +static bool acpi_osi_setup_disabled(char *str) {
>> > +       int i;
>> > +       struct osi_setup_entry *osi;
>> > +
>> > +       if (!str)
>> > +               return false;
>> > +
>> > +       for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
>> > +               osi = &osi_setup_entries[i];
>> > +               if (!strcmp(osi->string, str)) {
>>
>> Seems like we have one more user for
>> http://www.spinics.net/lists/kernel/msg2157535.html
> [Yu] This is nice, I can convert this patch to use match_string, and
> may I add my patch into your patchset? I saw there are some modifications
> on drivers in your patchset above.

Actually it will not help in this case. Sorry.

-- 
With Best Regards,
Andy Shevchenko
