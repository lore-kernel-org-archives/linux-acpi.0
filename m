From: geekcelibataire-GANU6spQydw@public.gmane.org
Subject: Re: [rfc] generic testing ACPI module
Date: Fri, 12 Mar 2004 22:22:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040312222244.5f523037.geekcelibataire@free.fr>
References: <1079038411.18351.25.camel@t40>
	<20040311211005.GM2148@parcelfarce.linux.theplanet.co.uk>
	<1079041694.5429.58.camel@t40>
	<20040311225032.GN28592@poupinou.org>
	<20040312144241.GA1236@openzaurus.ucw.cz>
	<20040312175724.GP28592@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040312175724.GP28592-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Is it possible to make file executable ? Whe could do somethink like :

$/sys/proc/acpi/methods/QXX param1 param2 param3 
Result : r1 r2 r3
$

On Fri, 12 Mar 2004 18:57:24 +0100
Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:

> On Fri, Mar 12, 2004 at 03:42:41PM +0100, Pavel Machek wrote:
> > Hi!
> > But ioctls are even worse. Why not simply
> > 	open METHOD
> > 	write PARAMETERS
> > 	read RESULTS
> > 	close
> 
> Because I'm too stupid to thing of your solution, I guess.
> 
> -- 
> Bruno Ducrot

-- 
Frederic Leroy
Lost in Germany


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
