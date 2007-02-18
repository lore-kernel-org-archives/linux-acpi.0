From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Mon, 19 Feb 2007 00:22:49 +0100
Message-ID: <20070218232249.GA11730@one.firstfloor.org>
References: <45D5EA88.7090300@redhat.com> <p73odntg9ga.fsf@bingen.suse.de> <45D606A0.5020606@redhat.com> <20070218183219.557856dc.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752440AbXBRXWx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070218183219.557856dc.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
List-Id: linux-acpi@vger.kernel.org

> You could blacklist the ACPI "thermal" module instead. If you're
> interested in monitoring your CPU temperature, k8temp is IMHO more
> convenient to use than ACPI, as it interfaces properly with libsensors
> and all hardware monitoring user interfaces.

That would be somewhat dangerous because ACPI thermal does more than
just displaying the temperature. Especially laptops often need it.

-Andi
