From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake
 howto was: RE: [BKPATCH] ACPI for 2.6
Date: Wed, 31 Mar 2004 14:51:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040331145147.59f3b49a.ak@suse.de>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com>
	<20040330233155.463A.COUNT0@localnet.com>
	<1080732363.4883.964.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080732363.4883.964.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org, harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 31 Mar 2004 13:26:04 +0200
Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org> wrote:


> So take my word: If I can with my limited experience in PM and x86
> hacking be of any help and someone can guide me to a point where I can
> start, I will try my very best to improve the situation - at least for
> the hardware I have access to.


Assuming you really want to help and not just complain:

Make sure everytime you see an oops or other problem that you file a bug 
in bugme.kernel.org. For oopses this must include the oops log, so 
make yourself familiar with serial consoles and netconsoles.

If possible take a look at the driver when you see an oops or problem
and try to fix it yourself an submit a patch.

If you do this for all hardware you have access to the problems may 
actually get fixed.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
