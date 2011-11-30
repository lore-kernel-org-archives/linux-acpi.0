From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: Regression in thinkpad-acpi events
Date: Wed, 30 Nov 2011 09:15:07 -0200
Message-ID: <20111130111507.GA32079@khazad-dum.debian.net>
References: <4EBAC3B5.5060405@gmail.com>
	<201111142031.06663.maciej.rutecki@gmail.com>
	<4EC16F8E.7060601@gmail.com>
	<201111142118.47256.maciej.rutecki@gmail.com>
	<CAG-2HqVnsmSyHVCvEVf+sZw5NxhR8qSDDB0AtR+igwCCFiwfgQ@mail.gmail.com>
	<20111115230305.GA23325@khazad-dum.debian.net>
	<20111127022346.32f11849@schlepp.lan> <4ED5F5D7.8020208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4ED5F5D7.8020208-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Natanji <natanji-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tom Gundersen <teg-B22kvLQNl6c@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henning Schild <henning-wy63DpzWjhr4ajHJ1XSv27NAH6kLmebB@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, maciej.rutecki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 30 Nov 2011, Natanji wrote:
> The standard Arch kernel does not use tuxonice, you need to build your
> kernel manually if you want it. I also don't receive these events before
> the first hibernation, so you might be having a different problem.

Just a hunch: check /proc/interrupts.  One of them must be assigned to acpi,
and it *must* increase when you press hotkeys, etc.

Does it?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
