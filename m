From: jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org (Johan Vromans)
Subject: DockApps (Was: Smart Battery System driver)
Date: Thu, 20 Jan 2005 22:27:31 +0100
Message-ID: <16880.8771.253591.739342@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[Quoting Rich Townsend, on January 19 2005, 08:31, in "Re: Smart Battery Sy"]
> However, I'm surprised that the GB applet doesn't get the AC state from 
> polling /proc/acpi/adapter/AC0/state. I use wmacpi, and that shows up 
> the AC state fine...

Speaking of wmacpi: what is your favorite (acpi-related) docapp for
your laptop? 

wmacpi is quite nice (needs a couple of patches, though).
wmlaptop is also quite nice, but its ACPI support doesn't seem up to
	 date.
wmpower is also nice, etc.
wmacpimon doesn't get the values right.

Most of them have some form of libacpi that does a varying job. It is
clear that using the SBS info would be much easier, and better.

-- Johan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
