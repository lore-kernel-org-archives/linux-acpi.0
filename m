From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: acpi patch for 2.6.7
Date: Thu, 16 Sep 2004 08:50:24 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095268733.11668.35.camel@neuromancer.home.net>
References: <200409061331.28311@geromy>  <20040907135637.GC3647@fuchi>
	 <1094606130.9577.41.camel@neuromancer.home.net>
	 <1095229747.13132.139.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1095229747.13132.139.camel-AdgCB+f5QAxwBzq2CxEN2SkBHpOjBR89@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-09-15 at 14:29, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2004-09-08 at 11:15, Ow Mun Heng wrote:
> > rm1-mm2, suspend code/something causes a need for a keyboard press to
> > start writing to swap. -rc1-mm3 does not compile at "make
> 
> Which version of suspend? 
Whatever is already included in the kernel. No patching was done

> You might try adding kdb in then breaking at
> the pause and getting a backtrace for the process that's suspending.
Hmm.. If only I knew what you were referring to. Walk me through please.

> 
> Regards,
> 
> Nigel

-- 
Ow Mun Heng
Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel
2.6.7-2.jul1-interactive 
Neuromancer 01:18:10 up 16:02, 7 users, load average: 1.93, 1.71, 1.29 


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
