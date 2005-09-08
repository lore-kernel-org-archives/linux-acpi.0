From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: Latest acpica
Date: Thu, 8 Sep 2005 13:30:57 -0600
Message-ID: <20050908193057.GB4770@parisc-linux.org>
References: <971FCB6690CD0E4898387DBF7552B90E02AA3FD6@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E02AA3FD6-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 08, 2005 at 12:23:50PM -0700, Moore, Robert wrote:
> Tell me what needs to change in order to make it compatible.

I've never looked into it in any detail.  From the Debian description:

 The behaviour of Flex has undergone a major change since version
 2.5.4a; Flex scanners are now reenterant, you may have multiple
 scanners in the same program with differing sets of defaults, and
 they play nicer with modern C and C++ compilers. The Flip side is
 that Flex no longer conforms to the POSIX lex behaviour, and the
 scanners require conforming implementations when flex is used in ANSI
 C mode. The package flex-old provides the older behaviour.

The GNU web page has some more detail:

http://www.gnu.org/software/flex/manual/html_chapter/flex_20.html#SEC20

and there's a bug showing exactly this problem being encountered here:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=191942

The important bit is probably the quote:

	The relevant change in the new flex is that it's no longer valid
	to call unput() from the section after %%, only in actions or
	in the %{ ... %} section.

HTH.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
