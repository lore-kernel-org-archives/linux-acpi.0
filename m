From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCH] cleanup ACPI numa warnings
Date: Sun, 08 Aug 2004 22:19:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1092025184.2292.26.camel@localhost.localdomain>
References: <1091738798.22406.9.camel@tdi>
	 <1091739702.31490.245.camel@nighthawk> <1091741142.22406.28.camel@tdi>
	 <249150000.1091763309@[10.10.2.4]>
	 <20040805205059.3fb67b71.rddunlap@osdl.org>
	 <20040807105729.6adea633.pj@sgi.com>
	 <20040808143631.7c18cae9.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S265943AbUHIETZ@vger.kernel.org>
In-Reply-To: <20040808143631.7c18cae9.rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, mbligh@aracnet.com, haveblue@us.ibm.com, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-08-08 at 14:36 -0700, Randy.Dunlap wrote:
> On Sat, 7 Aug 2004 10:57:29 -0700 Paul Jackson wrote:
> 
> | > And there's nothing in CodingStyle that agrees with you that I could find.
> | 
> | >From the file Documentation/SubmittingPatches:
> | 
> |         3) 'static inline' is better than a macro
> |
> Oops.  Thanks, Paul.

   Ok, I was all set to switch to static inlines, but it doesn't work.
Compiling w/ debug on, _dbg is undefined, which is part of the
ACPI_DB_INFO macro, but it only gets setup by the ACPI_FUNCTION_NAME
macro.  Guess I got lucky by choosing to do it as a macro.  IMHO, it
doesn't really make sense to make the static inline functions more
complicated or hide where they're getting called to make this all work.
So, I think the choices are to stick with the ugly macros or put #ifdefs
around the code and essentially leave it the way it is.  Sorry I didn't
give it a more thorough look when originally questioned.  Better ideas?
Thanks,

	Alex
