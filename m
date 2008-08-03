From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: acpi error on 2.6.27-rc1+ (ACPI Error (dsobject-0501))
Date: Sun, 3 Aug 2008 23:55:58 +0200
Message-ID: <200808032355.59016.rjw@sisk.pl>
References: <20080803182913.GB8691@joi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759733AbYHCVxg@vger.kernel.org>
In-Reply-To: <20080803182913.GB8691@joi>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Andi Kleen <andi@firstfloor.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

[Probably CC this to linux-acpi as well.]

On Sunday, 3 of August 2008, Marcin Slusarz wrote:
> Hi
> I noticed that 2.6.27-rc1+ (2b12a4c524812fb3f6ee590a02e65b95c8c32229) prints this:
> Completing Region/Field/Buffer/Package initialization:.ACPI Error (dsobject-0501): Package List length (EA) larger than NumElements count (3), truncated
> 
> Is it something to worry about?
> I've put full log, config and acpidump on http://www.kadu.net/~joi/kernel/2008.08.03/
