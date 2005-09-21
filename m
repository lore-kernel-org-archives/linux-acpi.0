From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: address space descriptors
Date: Wed, 21 Sep 2005 11:45:48 -0600
Message-ID: <200509211145.48358.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Can someone clarify the intended usage of the "address space"
descriptors for _CRS, _PRS, and _SRS?

These descriptors contain
	_MAF	1 => specified max address is fixed
	_MIF	1 => specified min address is fixed
	_MIN	address range minimum
	_MAX	address range maximum
	_LEN	address length

I've been assuming that _MAX and _LEN were redundant (because
_MAX = _MIN + _LEN - 1), but I suspect that this is incorrect,
and that the description should be more along the lines of
the "memory range" descriptors.

The memory range descriptors also contain _MIN and _MAX, but
the _MAX description is "maximum _base_ address for which the
card may be configured".  From that I would infer that the
length of the memory range is fixed, but the base of the range
can be set between _MIN and _MAX (subject to the alignment
constraints).

I'm wondering if the intent for address space descriptors is
similar, and that these are really fixed-length regions that
can be relocated to start between _MIN and _MAX.

I also don't know how to interpret _MAF and _MIF.  If the
point is to tell the OS whether the region is relocatable,
you should only need one bit (or even no bits at all, if
you just made _MIN == _MAX).


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
