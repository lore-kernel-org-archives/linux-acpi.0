From: Tod Morrison <tmorriso-o2OswTf4RFv//ikEAC0814dd74u8MsAO@public.gmane.org>
Subject: S1 could work
Date: Tue, 20 Jan 2004 18:25:13 -0700 (MST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0401201816420.4869@localhost.localdomain>
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

Hopefully this is can be done. I have partially functional S1 and S3 
states, in the case of S3 the LCD remains off after resume which I gather 
may be a problem for awhile, but I'm patient. The problem with S1 is just 
frustrating though, I have no way of powering of (i.e. dpms) from the 
console (setterm doesn't work) and S1 doesn't turn off the LCD. This 
wasn't a problem under 2.4 since I would just execute 'xset dpms force 
off' from within X before suspending. Unfortunately, in 2.6 acpi switches 
to a text console to display some messages prior to going into standby 
which breaks my only work around. I'd like to know if there's anyway 
around this, as it essentially makes 2.6 kernels unusable to me.

Tod Morrison <tmorriso-o2OswTf4RFv//ikEAC0814dd74u8MsAO@public.gmane.org>
   http://math.cudenver.edu/~tmorriso

  "Everyone thinks of changing the world,
  but no one thinks of changing himself."
  - Leo Tolstoy


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
