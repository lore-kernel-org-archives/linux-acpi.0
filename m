From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] ACPI: SPCR: Use access width to determine mmio usage
Date: Sat, 6 May 2017 18:39:48 -0400
Message-ID: <4e11bb2b-7cec-6a7b-ca2b-88be31a98b7d@redhat.com>
References: <1493910330-17913-1-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493910330-17913-1-git-send-email-jon.mason@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Mason <jon.mason@broadcom.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, bcm-kernel-feedback-list@broadcom.com, Loc Ho <lho@apm.com>
List-Id: linux-acpi@vger.kernel.org

On 05/04/2017 11:05 AM, Jon Mason wrote:
> The current SPCR code does not check the access width of the mmio, and
> uses a default of 8bit register accesses.  This prevents devices that
> only do 16 or 32bit register accesses from working.  By simply checking
> this field and setting the mmio string appropriately, this issue can be
> corrected.  To prevent any legacy issues, the code will default to 8bit
> accesses if the value is anything but 16 or 32.

Thanks for this. Just as an FYI I've a running discussion with Microsoft
about defining additional UART subtypes in the DBG2 for special case
UARTs. Specifically, I want to address AppliedMicro's special 8250 dw IP
that also has a non-standard clock. At this time, there is general
agreement to use the access width for some cases rather than defining
yet more subtypes - so your patch is good.

Loc/Applied: please track this thread, incorporate feedback, and also
track the other general recent discussions of 8250 dw from this week.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
