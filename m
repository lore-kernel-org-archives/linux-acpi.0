From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: DSDT in initrd
Date: Mon, 19 May 2003 16:53:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030519145332.GJ346@poupinou.org>
References: <A5974D8E5F98D511BB910002A50A6647054FC40A@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A5974D8E5F98D511BB910002A50A6647054FC40A-MgY+aF+eRfZviC08c4yzC1DQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>, mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 19, 2003 at 07:38:21AM -0700, Brown, Len wrote:
> I agree with Andy that the OSDs should avoid the DSDT distribution and
> support business.  It is the OEM's job to ship a working BIOS, and they will
> do so if they want to pass the OSD's certification test suite.
> 
> The concept of a DSDT override is a workaround -- fine for bringup,
> development, hackers, enthusiasts, wizards etc.  But somebody who pays money
> for a production box that runs Linux will buy one that the OSD certifies and
> supports.
> 
> So unless the Linux community wants to slide down the slippery slope of
> running any old broken BIOS -- forever -- we should maintain -- indeed
> sharpen -- our ability to reject bad firmware -- and generously apply that
> ability when the OEM goes before an OSD for certification.
> 

Most trouble come with laptops, not servers (almost all servers
that I have tested work without any real troubles for now).

BUT there is indeed a need to provide workarounds for
_laptops_ users.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
