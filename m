From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 17:09:08 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309031709.08286.adq_dvb@lidskialf.net>
References: <20030903080852.GA27649@k3.hellgate.ch> <20030903145356.35b9a192.skraw@ithnet.com> <200309031504.03596.vlad@lazarenko.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200309031504.03596.vlad-Qw1rWqDNyQwB085IDyDbTA@public.gmane.org>
Content-Disposition: inline
To: Vladimir Lazarenko <vlad-Qw1rWqDNyQwB085IDyDbTA@public.gmane.org>, Stephan von Krawczynski <skraw-DcQCyzbjH0jQT0dZR+AlfA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 03 Sep 2003 2:04 pm, Vladimir Lazarenko wrote:
> On my board, A7V8X, ACPI/APIC works just perfectly with 2.4.22 and KT400
> chipset, 

Does it indeed? Sounds like that BIOS doesn't have the bug! Can you send me 
your /proc/acpi/dsdt so I can see what is different? Be really good if I can 
nick the code out of that for the other boards!

> alas on A7N8X Deluxe board with nForce2 chipsets it causes nasty 
> hangups.
> Machine just simply freezes, no oops, nothing whatsoever.
>
> Disabling APIC solved the problem.

Does it work with ACPI disabled, but APIC enabled?
