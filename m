From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Subject: Re: 2.6.7 ACPI OOPS (random dereferrencing)
Date: Sun, 20 Jun 2004 07:59:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <40D5A642.6020901@backtobasicsmgmt.com>
References: <Pine.LNX.4.60.0406180957470.977@hosting.rdsbv.ro> <1087571167.22483.20.camel@forum-beta.geizhals.at> <Pine.LNX.4.58.0406201340560.1998@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S265500AbUFTO7Q@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406201340560.1998@kai.makisara.local>
To: linux-kernel@vger.kernel.org
Cc: Acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Kai Makisara wrote:

> The reports in the list above do not all point to similar symptoms. The 
> reports from Thomas, Kevin, Pozsar, and me seem to have two things in 
> common:
> - an Intel motherboard
> - hang when enabling ACPI

There is an entry in the RedHat Bugzilla where Len Brown is actively 
participating on this issue; he has been able to reproduce it (no 
surprise, he works for Intel and shouldn't have any trouble obtaining 
the same hardware <G>). There is no fix yet, though.
