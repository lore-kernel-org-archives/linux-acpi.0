From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: eliminate useless bay events
Date: Tue, 6 Mar 2007 23:16:49 -0300
Message-ID: <20070307021649.GA1448@khazad-dum.debian.net>
References: <20070306154046.942b0706.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161219AbXCGCRN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070306154046.942b0706.kristen.c.accardi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 06 Mar 2007, Kristen Carlson Accardi wrote:
> Eliminate bay events on resume if nothing has changed.

Are these *really* useless?  What if the *contents* of the bay changed?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
