From: Darren Hart <dvhart@infradead.org>
Subject: Re: [RFC 0/2] asus notebook fan control
Date: Thu, 30 Apr 2015 11:00:07 -0700
Message-ID: <20150430180007.GB40200@fury.dvhart.com>
References: <cover.1429653764.git.kastbernd@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1429653764.git.kastbernd@gmx.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Kast Bernd <kastbernd@gmx.de>
Cc: corentin.chary@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 22, 2015 at 04:12:26PM +0200, Kast Bernd wrote:
> Hello,
> 
> This patchset implements a fan control for asus notebooks.
> It's based on Felipe Contreras' patch
> (https://lkml.org/lkml/2013/10/8/800), that was proposed one and a half
> year ago, but never made it to the kernel, because of the use of
> "virt_to_phys".
> This problem is solved by using the acpi internal function that is
> activated by the first patch (ACPI_FUTURE_USAGE is removed).
> The second patch implements the actual fan control functions, with a
> similar logic than Felipe, but using hwmon instead of the thermal
> interface and some bugs removed.
> 
> This patchset contains the following 2 patches:
> 0001-ACPI-activate-export-acpi_os_get_physical_address.patch
> 0002-asus-wmi-add-fan-control.patch
> 
> This is my first kernel patch. I tried to respect all style rules and
> implement it properly. I couldn't find any try to fix the old patch in
> recent time, thus I wrote this new patch.
> 
> I would appreciate any kind of feedback to get this patch upstream.

Nice cover letter for your first patch submission, providing the context and the
reference is useful. Thanks for that.

I would suggest including Felipe on Cc (done).

Review to follow...

> 
> 
> Kast Bernd (2):
>   ACPI: activate&export acpi_os_get_physical_address
>   asus-wmi: add fan control
> 
>  drivers/acpi/osl.c              |   3 +-
>  drivers/platform/x86/asus-wmi.c | 297 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 278 insertions(+), 22 deletions(-)
> 
> -- 
> 2.3.5
> 
> 

-- 
Darren Hart
Intel Open Source Technology Center
