From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 19:35:44 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <A5974D8E5F98D511BB910002A50A66470B981254@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Hugh Dickins' <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Hugh Dickins [mailto:hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org] 

> > 		ACPI && !ACPI_HT_ONLY
> > 			Full ACPI w/o the acpi=cpu option
> 
> Shouldn't this combination also support "noht", or is that 
> too much to ask?

Can do.  It will be called CONFIG_ACPI_HT, and will be required for ACPI to
enable HT -- with or without the full CONFIG_ACPI.

Cheers,
-Len
