From: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Subject: _OSI and _OS DSDT methods
Date: Sat, 07 Feb 2004 16:04:26 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040207155315.5250.COUNT0@localnet.com>
References: <16420.5826.162449.28729@gargle.gargle.HOWL> <00d101c3ed98$3a226390$21b35452@KXPP>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Resent-Message-Id: <20040207164650.5254.COUNT0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
In-Reply-To: <00d101c3ed98$3a226390$21b35452-0YB+lduMvyg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The _OSI method is used in my DSDT in addition to the OS name returned
by the _OS method (http://www.microsoft.com/whdc/hwdev/tech/onnow/_OSI-method.mspx).

The results influence the behaviour of many other methods in the DSDT,
including sleep/wake methods. This OSFL() method is called and if/else
blocks depend on the return value:

Name (OSVR, Ones)
Method (OSFL, 0, NotSerialized) {
    If (LNot (LEqual (OSVR, Ones))) {
	Return (OSVR)
    }

    Store (0x01, OSVR)
    If (MCTH (\_OS, "Microsoft Windows NT")) {
	If (LEqual (OSVR, 0x01)) {
	    If (CondRefOf (_OSI, Local0)) {
		If (\_OSI ("Windows 2001")) {
		    Store (0x04, OSVR)
		}
	    } Else {
		Store (0x00, OSVR)
	    }
	}
    } Else {
	If (MCTH (\_OS, "Microsoft WindowsME: Millennium Edition")) {
	    Store (0x02, OSVR)
	}
    }

    Return (OSVR)
}


What should Linux return for _OS and _OSI? Should 2.6 mimic Windows XP?
Does it?

-Huw
-- 
Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
