From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Sun, 18 Feb 2007 18:32:19 +0100
Message-ID: <20070218183219.557856dc.khali@linux-fr.org>
References: <45D5EA88.7090300@redhat.com>
	<p73odntg9ga.fsf@bingen.suse.de>
	<45D606A0.5020606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751623AbXBRRcN@vger.kernel.org>
In-Reply-To: <45D606A0.5020606@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
List-Id: linux-acpi@vger.kernel.org

Hi Chuck,

On Fri, 16 Feb 2007 14:31:44 -0500, Chuck Ebbert wrote:
> Andi Kleen wrote:
> > Chuck Ebbert wrote:
> > > So, could ACPI and the k8temp driver be at odds?
> > 
> > Yes, there is no locking between ACPI and Linux drivers for register access.
> > e.g. if there is a indexed register both try to access (and temperature
> > sensors tend to use these things) they can race and get corrupted data.
> 
> I blacklisted the k8temp driver and everything looks OK now.

You could blacklist the ACPI "thermal" module instead. If you're
interested in monitoring your CPU temperature, k8temp is IMHO more
convenient to use than ACPI, as it interfaces properly with libsensors
and all hardware monitoring user interfaces.

-- 
Jean Delvare
