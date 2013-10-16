From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Wed, 16 Oct 2013 20:47:05 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31D31C65@ORSMSX106.amr.corp.intel.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
 <20131015165435.GA2777@naverao1-tp.ibm.com> <20131015170039.GF7908@pd.tnic>
 <525D7BCD.7080303@linux.vnet.ibm.com>
 <20131015214346.68718bcd.m.chehab@samsung.com>
 <20131016091640.GA13608@pd.tnic>
 <20131016073539.5a48f65e.m.chehab@samsung.com>
 <20131016104221.GC13608@pd.tnic> <20131016085558.19fe143a@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131016085558.19fe143a@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "Chen, Gong" <gong.chen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Aristeu Rozanski Filho <arozansk@redhat.com>, Steven Rostedt <srostedt@redhat.com>
List-Id: linux-acpi@vger.kernel.org

> Also, I suspect that, if an error happens to affect more than one DIMM
> (e. g. part of the location is not available for a given error),
> that the DIMM label will also not be properly shown.

There are a couple of cases here:

1) There are a number of DIMMs behind some flaky h/w that introduces errors
that are apparently blamed onto each of those DIMMs.

  All we can do here is statistical correlations ... each error is reported independently,
  it is up to some entity to notice the higher level topology connection. There is enough
  information in the UEFI error record to do that (assuming that BIOS filled out the
  necessary fields).

2) There is a single reported error that spans more than one DIMM.

  This can happen with a UC error in a pair of lock-step DIMMs.  Since the error is UC
  we know that two (or more) bits are bad.  But we have no way to tell whether the
  bad bits came from the same DIMM, or one bit from each (because we don't know
  which bits are bad - if we knew that, we could fix them :-)   The eMCA case should
  log two subsections in this case - one for each of the lockstep DIMMs involved. A user
  seeing this will should probably just replace both DIMMs to be safe.  If they wanted to
  diagnose further they should swap DIMMs around so this pair are no longer lockstepped
  and see if they start seeing correctable errors from each of the split pair - or if the UC
  errors move with one or the other of the DIMMs

-Tony
