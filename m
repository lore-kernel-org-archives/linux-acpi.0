From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [ACPI] Re: [PATCH] cleanup ACPI numa warnings
Date: Fri, 20 Aug 2004 15:22:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200408201522.41334.jbarnes@engr.sgi.com>
References: <1091738798.22406.9.camel@tdi> <2550950000.1092019997@[10.10.2.4]> <1093028151.4993.42.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268702AbUHTT1H@vger.kernel.org>
In-Reply-To: <1093028151.4993.42.camel@tdi>
Content-Disposition: inline
To: acpi-devel@lists.sourceforge.net
Cc: Alex Williamson <alex.williamson@hp.com>, "Martin J. Bligh" <mbligh@aracnet.com>, "Randy.Dunlap" <rddunlap@osdl.org>, Paul Jackson <pj@sgi.com>, haveblue@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, August 20, 2004 2:55 pm, Alex Williamson wrote:
>    I'm not sure where we stand on this, sorry for the delay.  To recap,
> the first patch I submitted cleaned up the original functions, but moved
> the ugliness up into multi-line macros.  People didn't like the macros
> and suggested static inlines.  However, static inlines don't work for
> this application because the debug print needs state setup by the
> ACPI_FUNCTION_NAME call.  IMHO, it's not worth setting up that state in
> the static inline function for this little bit of cleanup.
>
>    So, I think we left it at nobody liked the macros and static inlines
> don't work.  General unhappiness.  Below is a patch that doesn't attempt
> to cleanup the original code, it just adds the #ifdefs and range
> checking w/ no macros.  Does this look better?  Below is the original
> submit comment outlining the goal.  Thanks,

Yes please.

Jesse
