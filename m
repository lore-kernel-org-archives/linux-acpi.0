From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: driver to support ACPI AML calls to native firmware
Date: Fri, 5 Oct 2007 13:19:17 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A029DAE89@scsmsx411.amr.corp.intel.com>
References: <200709201420.24023.bjorn.helgaas@hp.com> <200710051058.55141.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <200710051058.55141.bjorn.helgaas@hp.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> Ping!  Tony, can you let me know your plans for this patch?  I'd
> like to get it into a distro release, and of course, it's best if
> you accept it first.

I'll put it in soon.  My only vague concern is whether it should be more
accessible for other OEMs who want to do the SAL/ACPI sharing thing. But
I can wait and see whether we get a proliferation of OEM specific
drivers doing the same kind of thing.  If we do, then we'll look at how
to merge the common stuff.

-Tony
