From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [ACPI] Re: [PATCH] cleanup ACPI numa warnings
Date: Sun, 8 Aug 2004 14:36:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040808143631.7c18cae9.rddunlap@osdl.org>
References: <1091738798.22406.9.camel@tdi>
	<1091739702.31490.245.camel@nighthawk>
	<1091741142.22406.28.camel@tdi>
	<249150000.1091763309@[10.10.2.4]>
	<20040805205059.3fb67b71.rddunlap@osdl.org>
	<20040807105729.6adea633.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S264717AbUHHVrl@vger.kernel.org>
In-Reply-To: <20040807105729.6adea633.pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: mbligh@aracnet.com, alex.williamson@hp.com, haveblue@us.ibm.com, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 7 Aug 2004 10:57:29 -0700 Paul Jackson wrote:

| > And there's nothing in CodingStyle that agrees with you that I could find.
| 
| >From the file Documentation/SubmittingPatches:
| 
|         3) 'static inline' is better than a macro
| 
|         Static inline functions are greatly preferred over macros.
|         They provide type safety, have no length limitations, no formatting
|         limitations, and under gcc they are as cheap as macros.
| 
|         Macros should only be used for cases where a static inline is clearly
|         suboptimal [there a few, isolated cases of this in fast paths],
|         or where it is impossible to use a static inline function [such as
|         string-izing].

Oops.  Thanks, Paul.

I agree that the inline looks better than the macro (more readable,
possibly more maintainable), but not that the multi-line macro
is _evil_ (which is what Martin said).


--
~Randy
