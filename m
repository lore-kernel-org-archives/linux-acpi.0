From: Tod Morrison <tmorriso-o2OswTf4RFv//ikEAC0814dd74u8MsAO@public.gmane.org>
Subject: Thermal Shutdown
Date: Wed, 18 Feb 2004 19:55:22 -0700 (MST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0402181948540.4376@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Trying to make the move to 2.6 on my Inspiron 8500, I've played with a 
number of 2.6 kernels. Twice now I've had my system to a hard (BIOS 
initiated) thermal shutdown. This only happens with 2.6 kernels 
(2.6.1-mm?) and (2.6.3_rc3), which I've noticed tend to run much hotter. 
With 2.4 I rarely see 80C and under heavy load 85C, but with the 2.6 
kernels I'm usually running at 77C under little load, so I doubt this is 
some kind of miscalculation. At this point I'm really just looking for 
suggestions on how to proceed in this investigation: what could it be? 
what can I test?

Tod Morrison <tmorriso-o2OswTf4RFv//ikEAC0814dd74u8MsAO@public.gmane.org>
   http://math.cudenver.edu/~tmorriso

  "Everyone thinks of changing the world,
  but no one thinks of changing himself."
  - Leo Tolstoy


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
