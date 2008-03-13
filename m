From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: PNP: increase the maximum number of resources
Date: Thu, 13 Mar 2008 01:16:57 +0100
Message-ID: <47D87279.7070905@keyaccess.nl>
References: <20080312151452.GA4523@codemonkey.org.uk> <200803121345.21297.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756143AbYCMAQa@vger.kernel.org>
In-Reply-To: <200803121345.21297.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-acpi@vger.kernel.org, Adam M Belay <abelay@mit.edu>, Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Thomas Renninger <trenn@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12-03-08 18:45, Len Brown wrote:

> Thomas worked on a patch to make resource allocation dynamic and do away
> with these limits.  Unfortunately it was rather large and it wasn't in
> time for the 2.6.25-rc1 window.  So right now we are on a trajectory
> for 2.6.25 to behave exactly like 2.6.24.
> Indeed, I don't think that patch made it into the test tree,
> so unless we revive that patch, it will miss 2.6.26 as well.

It rather violently broke ISAPnP.

Rene.
