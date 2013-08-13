From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error
 trace event
Date: Tue, 13 Aug 2013 14:33:43 +0200
Message-ID: <20130813123343.GB4077@pd.tnic>
References: <20130808163822.67e0828a@samsung.com>
 <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com>
 <20130812123813.GD18018@pd.tnic>
 <20130812114932.52bb0314@samsung.com>
 <20130812150424.GH18018@pd.tnic>
 <20130812142557.2a43f155@samsung.com>
 <20130812175631.GI18018@pd.tnic>
 <520A1A2E.9080500@linux.vnet.ibm.com>
 <20130813092154.1e17385f@concha.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130813092154.1e17385f@concha.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Aristeu Rozanski Filho <arozansk@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 13, 2013 at 09:21:54AM -0300, Mauro Carvalho Chehab wrote:
> > > More specifically, what are those gdata_fru_id and gdata_fru_text
> > > things?
> > 
> > My understanding was that this provides the DIMM serial number, but I'm 
> > double checking just to be sure.

Hm, ok, then.

If this info is exported to userspace over i2c or DMI (I've seen
it sometimes in dmidecode output too) then the information in the
tracepoint can be used in conjunction with dmidecode output to map back
to the DIMM or so...

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
