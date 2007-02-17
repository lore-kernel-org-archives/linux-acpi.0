From: Rudolf Marek <r.marek@assembler.cz>
Subject: Re: Could the k8temp driver be interfering with ACPI?
Date: Sat, 17 Feb 2007 11:49:50 +0100
Message-ID: <45D6DDCE.5050803@assembler.cz>
References: <45D5EA88.7090300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lm-sensors-bounces@lm-sensors.org>
In-Reply-To: <45D5EA88.7090300@redhat.com>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/lm-sensors>
List-Post: <mailto:lm-sensors@lm-sensors.org>
List-Help: <mailto:lm-sensors-request@lm-sensors.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=subscribe>
Sender: lm-sensors-bounces@lm-sensors.org
Errors-To: lm-sensors-bounces@lm-sensors.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
List-Id: linux-acpi@vger.kernel.org

Hello Chuck,

I'm the author of K8temp. Please can you share with us your DSDT table?
(cat /proc/acpi/dsdt > /tmp/dsdt.bin)

> So, could ACPI and the k8temp driver be at odds?

Yes because ACPI AML code has no synchronization with Linux drivers. Second
reason is that ACPI AML code assign resource regions to itself but with cleared
busy flag - so other drivers could bind and might possibly interfere  with ACPI.

This is very long term problem, I already proposed some possible solutions to
this problem
(http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018788.html)

There are some ideas, but none is implemented yet. As you already wrote, best
solution is to stop using k8temp driver.

I will check the DSDT table to confirm this fact.

Thanks,
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
