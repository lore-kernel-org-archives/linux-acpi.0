From: kneumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org
Subject: Re: RE: Thermal OOPS fixed
Date: Tue, 01 Oct 2002 22:52:09 +0200 (MEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.SOL.4.21.0210012247410.28739-100000@neptun>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DEE6@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <EDC461A30AC4D511ADE10002A5072CAD0236DEE6-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Knut Neumann' <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 1 Oct 2002, Grover, Andrew wrote:
> I will fix the timer init problem. Can you submit a patch for the rmmod
> /proc issue?

Not yet, but I am working on it. It seems that something goes wrong in
acpi_bus_unregister_driver. Obviously acpi_thermal_remove does not get
called. I will submit a patch if I can as soon as possible.

Can anyone else reproduce the problem?

-Knut




-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
