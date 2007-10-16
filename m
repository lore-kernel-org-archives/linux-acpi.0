From: Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 2/2] Recent Lenovo ThinkPads define a
	dummy grahpics	device, find it and ignore it
Date: Tue, 16 Oct 2007 19:50:53 +0200
Message-ID: <20071016175053.GB17671@netswarm.net>
References: <1192465995.9847.587.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1192465995.9847.587.camel-X8wR35IVlAxolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: linux-acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li,  Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ibm-acpi-devel <ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 15, 2007 at 06:33:15PM +0200, Thomas Renninger wrote:
> Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it

I think it's ok. dmesg says:

ACPI: Video device VID not physically connected, ignoring
input: Video Bus as /devices/virtual/input/input11
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)

# ls /proc/acpi/video/
VID/

(Only one entry now -> good)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
