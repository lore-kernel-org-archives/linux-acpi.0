From: Daniel Walker <dwalker@fifo99.com>
Subject: RE: [PATCH 5/7] acpi: fix a bunch of style issues on 'actypes.h'
Date: Fri, 13 Nov 2009 13:48:42 -0800
Message-ID: <1258148922.6411.20.camel@c-dwalke-linux.qualcomm.com>
References: <1255906474-25091-1-git-send-email-felipe.contreras@gmail.com>
	 <1255906474-25091-6-git-send-email-felipe.contreras@gmail.com>
	 <alpine.LSU.2.00.0910191616290.8582@wotan.suse.de>
	 <1258145921.6411.18.camel@c-dwalke-linux.qualcomm.com>
	 <4911F71203A09E4D9981D27F9D8308583E43CEEB@orsmsx503.amr.corp.intel.com>
	 <alpine.LSU.2.00.0911132239160.15039@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756428AbZKMVss@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.00.0911132239160.15039@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "Moore, Robert" <robert.moore@intel.com>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2009-11-13 at 22:41 +0100, Jiri Kosina wrote:
> On Fri, 13 Nov 2009, Moore, Robert wrote:
> 
> > >> And after today's discussion on kernel summit on this topic, I 
> > >> wouldn't expect any maintainer to merge it, sorry :)
> > >could you be more specific about what "discussion" you are talking
> > >about.
> > Yes, do tell.
> 
> I have probably lost the track of the context here already, sorry.
> 
> But it probably had something to do with the fact that whitespace-only 
> patches (which [PATCH 5/7] acpi: fix a bunch of style issues on 
> 'actypes.h' has been, as far as I remember), are unnecessary noise.

I don't think it was clear from the description , but I think this is
actually a checkpatch cleanup. So it's not just random whitespace
changes. AFAIK, maintainers do accept those.

Daniel
