From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Fri, 06 Aug 2004 13:03:30 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091822609.16369.29.camel@neuromancer.home.net>
References: <1091139240.26511.9.camel@6-allhosts>
	 <yzo7jse5999.fsf@localhost.localdomain>
	 <200408051453.55710.stefandoesinger@gmx.at>
	 <200408051914.39445.anib@anib.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408051914.39445.anib-La3J9u0raUk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-08-05 at 10:14, Alexander Bruder wrote:
> Hi,
> 
> > Intel's new graphics chipset probably. Owners of Acer Travelmate 60X told
> > me that the video doesn't come back. But in the these case the whole system
> > locked up on resume, so we can't tell if the video resume works.
> 
> it also happends for the 80x series (in my case 801Lcib) with ATI Technologies 
> Inc Radeon R250 Lf [Radeon Mobility 9000] using the framebuffer. 
> "echo 3 > /proc/acpi/sleep" and "echo 4 > /proc/acpi/sleep" doesn't work 

echo 4 works on My D600 Radeon 9000. S3 doesn't. FC2 on 2.6.7 kernel


-- 
Ow Mun Heng
Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel
2.6.7-2.jul1-interactive 
Neuromancer 13:01:00 up 4:19, 5 users, load average: 2.28, 1.93, 2.64 


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
