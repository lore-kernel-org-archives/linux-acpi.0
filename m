From: Juan Quintela <quintela-vTSrGsn2Cd4dnm+yROfE0A@public.gmane.org>
Subject: Re: [BK PATCH] acpismp=force fix
Date: Mon, 30 Jun 2003 17:42:29 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <863chrshay.fsf@trasno.mitica>
References: <A5974D8E5F98D511BB910002A50A66470B981205@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B981205-MgY+aF+eRfZviC08c4yzC1DQ4js95KgL@public.gmane.org> (Len
 Brown's message of "Thu, 26 Jun 2003 14:37:11 -0700")
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Arjan van de Ven' <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>, torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>>>> "brown," == Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:

Hi

brown,> To disable HT on a uni-processor, wouldn't it be preferable to simply run
brown,> the UP kernel rather than the SMP kernel with HT disabled?  That leaves SMP
brown,> systems, where either the BIOS could disable it (it is a BIOS bug if it
brown,> can't), or as a last resort CONFIG_X86_HT (2.5) could be config'd out of the
brown,> kernel.  I guess I've talked myself into not missing "noht" also.

noht is very useful for distributions, we already have to do a lot of
kernels,  any option that "mandates" to compile a different kernel is
just bad (IMHO).

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
