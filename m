From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Mon, 30 Sep 2002 02:00:16 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020930020016.A90@toy.ucw.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <20020918055456.H202@toy.ucw.cz> <200209260237.25534.earny@net4u.de> <200209260406.48808.earny@net4u.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200209260406.48808.earny-euM3SP4ZHrg@public.gmane.org>; from earny-euM3SP4ZHrg@public.gmane.org on Thu, Sep 26, 2002 at 04:06:48AM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!
  > Yupp, i can reproduce this. Heated up with burnP6 an a little 'partial cooling 
> preventer' to aprox. 65 to 75°C (the temperature display jumps between this 
> values in the thermalzone, fan is forced 'off', means running half speed). 
> The laptop is doing his job without problems...  i type reboot:
> 
> [.... the kernel loads ....]
> md: ... autorun DONE.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols ICMP, UDP, TCP, IGMP
> Unable to handle kernel NULL pinter dereference at virtual address 00000004
>  printing eip
> c011fe45
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c011fe45>]  Not tainted

Can you ksymoops it?

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
