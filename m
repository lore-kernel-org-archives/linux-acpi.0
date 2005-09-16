From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: fans not working after suspend to disk on nc-4000 and nc-8000
Date: Fri, 16 Sep 2005 23:18:44 +0200
Message-ID: <20050916211844.GC15219@message-id.gmane0305.slipkontur.de>
References: <E1ECHiU-0005le-00@dorka.pomaz.szeredi.hu> <20050907183218.GA773@openzaurus.ucw.cz> <E1EDgJz-0000PH-00@dorka.pomaz.szeredi.hu> <20050910215552.GA2463@openzaurus.ucw.cz> <E1EFCcc-0008Jy-00@dorka.pomaz.szeredi.hu> <20050914210420.GD3460@elf.ucw.cz> <E1EFqlx-0002iN-00@dorka.pomaz.szeredi.hu> <20050915103219.GC2725@elf.ucw.cz> <E1EFrKP-0002mG-00@dorka.pomaz.szeredi.hu> <20050915111152.GD2725@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050915111152.GD2725-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 15, 2005 at 01:11:52PM +0200, Pavel Machek wrote:
> Hi!
 
> > Well, but ACPI seems to rely on it.  You can't have it both ways.
> > Either ACPI should be tought not to rely on S4 and reinitialize
> > everything after resume, or to rely on S4 but then _require_ S4 for
> > suspend.  Am I not right?
> 
> You are right, it is broken. OTOH S4 hangs some machine in
> ugly/undebuggeable ways. But perhaps that was already fixed?

FWIW, since SUSE 9.3 platform is default on SUSE and i have seen some,
but not too much reports of machines that work better with shutdown.
So maybe we should start to do "the right thing" as default, and
document the possibility of using "shutdown" mode prominently.
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
