From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BK PATCH] ACPI Updates for 2.4
Date: Wed, 13 Aug 2003 18:20:02 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F3AB992.4000506@pobox.com>
References: <F760B14C9561B941B89469F59BA3A8470255EECD@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EECD-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hps-NuKNLqtyCiEuZeo0DBJMuQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This ACPI update also fixes the irq routing issues I was seeing in 
2.4.22-rc2.  Previously, on Intel ICH5, I had to either disable 
CONFIG_ACPI (which makes my 2nd HT CPU disappear) and boot with 
'noapic', or disable CONFIG_SMP and boot with pci=noacpi.  If I did not 
do this, interrupts to the PCI slots would never be delivered.

With this update, 2.4 now matches 2.6 behavior:
full hyperthread, and interrupts routed correctly.

	Jeff
