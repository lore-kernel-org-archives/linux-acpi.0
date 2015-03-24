From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Tue, 24 Mar 2015 15:21:17 -0500
Message-ID: <5511C73D.5020006@dell.com>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com> <5510FB37.6030808@dell.com> <20150324152412.GA4706@codeblueprint.co.uk> <3241492.O6brgYIrX9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3241492.O6brgYIrX9@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matt Fleming <matt@codeblueprint.co.uk>
Cc: Jason Ekstrand <jason@jlekstrand.net>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org


On 03/24/2015 03:02 PM, Rafael J. Wysocki wrote:
> On Tuesday, March 24, 2015 03:24:12 PM Matt Fleming wrote:
> While I agree in general, one comment.
>
> We haven't decided about the patch yet.  We may decide to bump up the _REV
> to 6 when ACPI 6 is out instead.
I'd be happy with this too.
> That said the whole using of _REV to special case Linux is broken by design
> and should be stopped immediately.  Especially when it is done by comparing
> the return value of _REV to a specific number (like 5 or 3).
>
> Rafael
>
Yes, it's been made clear to me that this shouldn't be used in the future.  I've shared that feedback to my BIOS architecture team.
