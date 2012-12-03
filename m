From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 1/3] aerdrv: Trace Event for AER
Date: Mon, 03 Dec 2012 12:26:33 -0800
Message-ID: <1354566393.3524.9.camel@joe-AO722>
References: <20121203183305.26636.22979.stgit@grignak.americas.hpqcorp.net>
	 <1354564292.3524.7.camel@joe-AO722>
	 <A961433CDFF2F640A2866803152E61F9516EE733@G4W3218.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <A961433CDFF2F640A2866803152E61F9516EE733@G4W3218.americas.hpqcorp.net>
Sender: linux-pci-owner@vger.kernel.org
To: "Ortiz, Lance E" <lance.oritz@hp.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, "lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>, "jiang.liu@huawei.com" <jiang.liu@huawei.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mchehab@redhat.com" <mchehab@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2012-12-03 at 20:20 +0000, Ortiz, Lance E wrote:
> > > +#define correctable_error_string			\
> > > +	{BIT(0),	"Receiver Error"},		\
> > > +	{BIT(6),	"Bad TLP"},			\
> > > +	{BIT(7),	"Bad DLLP"},			\
> > > +	{BIT(8),	"RELAY_NUM Rollover"},		\
> > > +	{BIT(12),	"Replay Timer Timeout"},	\
> > > +	{BIT(13),	"Advisory Non-Fatal"}
> > > +
> > > +#define uncorrectable_error_string			\
> > > +	{BIT(4),	"Data Link Protocol"},		\
> > > +	{BIT(12),	"Poisoned TLP"},		\
> > > +	{BIT(13),	"Flow Control Protocol"},	\
> > > +	{BIT(14),	"Completion Timeout"},		\
> > > +	{BIT(15),	"Completer Abort"},		\
> > > +	{BIT(16),	"Unexpected Completion"},	\
> > > +	{BIT(17),	"Receiver Overflow"},		\
> > > +	{BIT(18),	"Malformed TLP"},		\
> > > +	{BIT(19),	"ECRC"},			\
> > > +	{BIT(20),	"Unsupported Request"}
> > 
> > probably better to prefix these with aer_
> 
> If I add aer_ it will conflict with string array in aerdrv_errprint.c

Maybe just not something quite so generic.
maybe aer_trace_correctable and aer_trace_uncorrectable

cheers, Joe
