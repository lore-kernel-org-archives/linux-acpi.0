From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [PATCH v2] acpi_power_meter: hwmon driver for ACPI 4.0 power
	meters
Date: Tue, 18 Aug 2009 09:24:05 -0700
Message-ID: <20090818162405.GB10233@tux1.beaverton.ibm.com>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com> <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com> <alpine.LFD.2.00.0907272124110.4445@localhost.localdomain> <20090803205812.GC14694@plum> <20090806204255.GD14694@plum> <20090817150558.3468426b.akpm@linux-foundation.org>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758025AbZHRQYI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090817150558.3468426b.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 17, 2009 at 03:05:58PM -0700, Andrew Morton wrote:
> > +	if (ACPI_FAILURE(status)) {
> > +		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PAI"));
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (data)
> > +		return -EINVAL;
> 
> I find this test of `data' inexplicable.  Is it just me, or do we need
> a comment here?

ACPI spec says that the _PAI method passes back 0 on success.  I guess I'll
reroll the patch with a comment stating that.

> > +	if (ACPI_FAILURE(status)) {
> > +		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _SHL"));
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (data)
> > +		return -EINVAL;
> 
> ditto.

Ditto.

--D
