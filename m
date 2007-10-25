From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [Fwd: [PATCH 3/5] Export acpi_check_resource_conflict]
Date: Thu, 25 Oct 2007 15:48:33 +0200
Message-ID: <20071025154833.0240b8a2@hyperion.delvare>
References: <1193236387.4590.230.camel@queen.suse.de>
	<20071024205347.6948c081.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759003AbXJYNsp@vger.kernel.org>
In-Reply-To: <20071024205347.6948c081.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Andrew,

On Wed, 24 Oct 2007 20:53:47 -0700, Andrew Morton wrote:
> On Wed, 24 Oct 2007 16:33:07 +0200 Thomas Renninger <trenn@suse.de> wrote:
> 
> > From: Thomas Renninger <trenn@suse.de>
> > To: linux-acpi <linux-acpi@vger.kernel.org>
> > Cc: linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jean Delvare <khali@linux-fr.org>
> > Reply-To: trenn@suse.de
> > Subject: [Fwd: [PATCH 3/5] Export acpi_check_resource_conflict]
> > Date: Wed, 24 Oct 2007 16:33:07 +0200
> > Organization: Novell/SUSE
> > X-Mailer: Evolution 2.8.2 
> > 
> > Export acpi_check_resource_conflict(), sometimes drivers already have
> > a struct resource at hand so no need to use the wrappers to build a new
> > one.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > ---
> 
> The attributions on this are all mucked up.
> 
> I _think_ it was written by Jean, in which case the changlog should
> have had From:him right at the start to indicate this.  And as you
> were in the delivery path, it should have had your signoff.
> 
> I'll make those changes - please let me know if I misguessed.

You are correct, patches 3/5, 4/5 and 5/5 of this patchset were written
by me (as in: I'm the one to blame if something breaks). I expected
Thomas to add a From: header and add his own Signed-off-by line but
instead he forwarded my mails directly. Thanks for fixing up the mess,
we'll try to make it better next time.

-- 
Jean Delvare
