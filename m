From: Nick Piggin <piggin-/x7JMgtu12E0n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH] ACPI pci irq routing fix
Date: Sat, 27 Sep 2003 15:54:33 +1000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F752619.5000406@cyberone.com.au>
References: <20030926182128.C24360@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030926182128.C24360-BI/OLcgY7/cyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
To: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Chris Wright wrote:

>If irq.active is set from _CRS, make sure to use it, rather than trying
>anything from the from the _PRS list, as some machines don't handle this
>properly.  This patch is against current linux-acpi-test-2.6.0.  It's
>been floating about for a while, and fixes bug #1186.
>
>Patch originally from Andrew de Quincey.
>
>thanks,
>-chris
>

This fixes my bug #1257.
