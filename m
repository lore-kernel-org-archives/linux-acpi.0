From: Christian Zoz <zoz-l3A5Bk7waGM@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Mon, 17 Feb 2003 06:40:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030217054032.GN3535@suse.de>
References: <200302140753.h1E7rOD00889@ikffws2.ikff.uni-stuttgart.de> <Pine.LNX.4.33.0302140836140.1067-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302140836140.1067-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 14, Patrick Mochel wrote:
> 
> > > This particular item is dangerous and will be removed from the kernel.
> > 
> > Is it up to you to decide that? ;-)
> 
> As a matter of fact, yes it is. And it has been removed from Linus's 2.5 
> tree as of last night. 

This is very very poor.

> Note that the argument is moot anwyay - there exists a sysrq key 
> combination that calls pm_power_off() (which points to acpi_power_off()). 
> This gives users the ability to turn their system off immediately, though 
> removes it from procfs. 

Switch it off!!! It's dangerous!

:(

-- 

ciao, christian

  --------------------------------------------------------------------
    Verglichen mit jedem x-beliebigen Redmonder Betriebssystem-Clone
    ist Linux geradezu eine leuchtende Perle der Datensicherheit.
  ------ Frank Rennemann (http://www.linux-knowledge-portal.org) -----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
