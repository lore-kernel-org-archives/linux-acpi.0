From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Re: [PATCH] Don't disable interrupts during EC access
Date: Wed, 17 Nov 2004 13:25:41 +0100
Message-ID: <20041117122541.GJ4620@wotan.suse.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC076@pdsmsx403> <20041116121616.GG1108@parcelfarce.linux.theplanet.co.uk> <20041116122946.GG28839@wotan.suse.de> <20041117012527.GB10900@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041117012527.GB10900-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 17, 2004 at 02:25:27AM +0100, Stefan Seyfried wrote:
> On Tue, Nov 16, 2004 at 01:29:46PM +0100, Andi Kleen wrote:
>  
> > And the event polling can take several ms, there is just no way 
> > to do this during runtime with interrupts off. Especially since
> > thermal will do this every few seconds. With my patch at least 
> > only kacpid is blocked for that long, not the whole system.
> 
> may this also help the awfully slow battery polling on some machines
> (e.g. Dell D600) or is this a completely different case?

Yes, it should help exactly this case. Or at least least it fixes
the problem on a Presario A64 laptop.

-Andi



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
