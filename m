From: "Martin J. Bligh" <mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] SMP parsing rewrite, phase 1
Date: Mon, 20 Jan 2003 20:28:20 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1504840000.1043123300@titus>
References: <Pine.LNX.4.44.0301201834310.26042-100000@dexter.groveronline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0301201834310.26042-100000-SNx59YkgthvyYw2uXbqB2185lzT46atW@public.gmane.org>
Content-Disposition: inline
To: Andy Grover <agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Would be a lot easier to read if you could seperate out the
renames from the rest of the patch that actually does things.
It all makes me slightly nervous as this stuff is really easy
to break ... and it breaks wierd machines that are hard to test
for (been there, done that ;-)).

+static u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };

Looks odd. May have merged forward badly, that got renamed in 2.5.59
to bios_cpu_apicid or something. 

Anyway, I'll give it a spin on my wierdo box, and see what happens.

M.
