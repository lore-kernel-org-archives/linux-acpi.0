From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: reading battery status and CPU time
Date: Thu, 10 Apr 2003 14:41:39 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030410144139.6e529f54.rddunlap@osdl.org>
References: <B900970C7DD9474C972986EB3EC7C58F0D4098@andromeda.agcad.local>
	<Pine.LNX.4.53.0304102315390.1659@tweety.gaugusch.at>
	<20030410213128.GG11811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030410213128.GG11811-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 10 Apr 2003 22:31:28 +0100 Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> wrote:

| On Thu, Apr 10, 2003 at 11:20:30PM +0200, Markus Gaugusch wrote:
| > I found something out about battery info being read twice:
| > (this is battery.c, acpi_battery_get_info())
| > 
| > Why is acpi_extract_package called twice with different error handling?
| > The ASL code is definitely called twice (I've put debug statements in
| > there).
| 
| Memory management.  The first time, it's called to find out how much
| memory it'll need; then we allocate some memory, then we call it again.
| There's an API to have the ACPICA allocate memory for you now, but I
| think it still calls the AML twice.

Willy, is this the proc-fs phenomenon?
which will go away if this code is converted to use seq_file...

--
~Randy   ['tangent' is not a verb...unless you believe that
          "in English any noun can be verbed."]


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
