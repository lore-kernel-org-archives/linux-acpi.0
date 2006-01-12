From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: soft lockup detected in acpi_processor_idle() -- false positive?
Date: Thu, 12 Jan 2006 19:43:05 +0100
Message-ID: <20060112184305.GA7068@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Latest git, fresh after resuming from suspend-to-disk (in-kernel variant):

[4294914.586000] Restarting tasks... done
[4294922.657000] BUG: soft lockup detected on CPU#0!
[4294922.657000] 
[4294922.657000] Pid: 0, comm:              swapper
[4294922.657000] EIP: 0060:[<f003084c>] CPU: 0
[4294922.657000] EIP is at acpi_processor_idle+0x1f3/0x2d5 [processor]
[4294922.657000]  EFLAGS: 00000282    Not tainted  (2.6.15)
[4294922.657000] EAX: fffff000 EBX: 005543a8 ECX: 00000000 EDX: 00000000
[4294922.657000] ESI: edcc3064 EDI: edcc2f60 EBP: c041cfdc DS: 007b ES: 007b
[4294922.657000] CR0: 8005003b CR2: 080c3000 CR3: 2d530000 CR4: 000006d0


As acpi_processor_idle doesn't take any locks AFAIK, it seems to me to be a
false positive -- or do I miss something obvious?

	Dominik
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
