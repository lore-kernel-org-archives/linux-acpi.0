From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: [PATCH] Don't disable interrupts during EC access
Date: Wed, 17 Nov 2004 12:50:21 +0100
Message-ID: <20041117115021.GA24492@message-id.gmane0305.slipkontur.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC091@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC091@pdsmsx403>
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

On Wed, Nov 17, 2004 at 06:56:07PM +0800, Yu, Luming wrote:

> >may this also help the awfully slow battery polling on some machines
> >(e.g. Dell D600) or is this a completely different case?
> 
> I'm not sure before you clearly describe your specific problem.

Ok, i thought this was a well known problem. (everybody i know seems to have
experience with it :-)

On a Dell Latitude D600 (other machines also, but this i have tested more
extensively), a "cat /proc/acpi/battery/BAT0/info" takes 180msec with
CPU at 600MHz. With CPU at 1700MHz it takes 70msec.

e239:~ # time cat /proc/acpi/battery/BAT0/info > /dev/null

real    0m0.182s
user    0m0.002s
sys     0m0.178s
e239:~ # powersave -f
Speed set to maximum
e239:~ # time cat /proc/acpi/battery/BAT0/info > /dev/null

real    0m0.068s
user    0m0.000s
sys     0m0.067s

this time is 100% kernel time and polling battery makes e.g. DVD playback
"stutter" visibly. The machine basically comes to a halt for ~0.2sec.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
