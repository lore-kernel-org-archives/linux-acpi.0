From: Andrzej Prochyra <andrzej@prochyra.name>
Subject: Re: [PATCH] ACPI / Video: blacklist some samsung laptops
Date: Mon, 09 Jan 2012 22:34:06 +0000
Message-ID: <878vlgjyjl.fsf@prochyra.name>
References: <20120105150832.GA25386@ubuntu-macmini>
	<1325945558-4661-1-git-send-email-corentincj@iksaif.net>
	<CANq1E4QGahjrxm5B59HGnrfO3LP4kV6bc27BKQDvnJ4HBKAFMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CANq1E4QGahjrxm5B59HGnrfO3LP4kV6bc27BKQDvnJ4HBKAFMg@mail.gmail.com>
	(David Herrmann's message of "Mon, 9 Jan 2012 17:39:43 +0100")
Sender: platform-driver-x86-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Richard =?utf-8?Q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

David Herrmann <dh.herrmann@googlemail.com> writes:
> On Sat, Jan 7, 2012 at 3:12 PM, Corentin Chary <corentincj@iksaif.net> wrote:
>> On these laptops, the ACPI video is not functional, and very unlikely
>> to be fixed by the vendor. Note that intel_backlight works for some
>> of these laptops, and the backlight from samsung-laptop always work.
>>
>> The good news is that newer laptops have functional ACPI video device
>> and won't end up growing this list.
>>
>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>> ---
>>
>> Could the concerned people test this patch and check that it correctly
>> disable the acpi_video backlight ?
>
> Works like a charm on my N210 with linux-3.2. Feel free to add a:
> Tested-by: David Herrmann <dh.herrmann@googlemail.com>
>
> I will talk to the intel drm developers about the intel_backlight
> issues as they don't seem related to this driver.

I can confirm on my N150 Plus.  Now only 'intel_backlight' is created
and exhibits the aforementioned issues.

-- 
Andrzej Prochyra
<andrzej@prochyra.name>
