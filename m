From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 0/5] ACPI / processor_idle: Add ACPI v6.0 LPI support
Date: Wed, 22 Jun 2016 18:45:15 +0100
Message-ID: <576ACEAB.6050306@arm.com>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On 14/06/16 15:48, Sudeep Holla wrote:
> ACPI 6.0 introduced LPI(Low Power Idle) states that provides an alternate
> method to describe processor idle states. It extends the specification
> to allow the expression of idle states like C-states selectable by the
> OSPM when a processor goes idle, but may affect more than one processor,
> and may affect other system components.
>
> LPI extensions leverages the processor container device(again introduced
> in ACPI 6.0) allowing to express which parts of the system are affected
> by a given LPI state. It defines the local power states for each node
> in a hierarchical processor topology. The OSPM can use _LPI object to
> select a local power state for each level of processor hierarchy in the
> system. They used to produce a composite power state request that is
> presented to the platform by the OSPM.
>
> Since multiple processors affect the idle state for any non-leaf hierarchy
> node, coordination of idle state requests between the processors is
> required. ACPI supports two different coordination schemes: Platform
> coordinated and  OS initiated.
>
> This series aims at providing basic and initial support for platform
> coordinated LPI states.
>

Gentle ping, was hoping to target this series for v4.8

-- 
Regards,
Sudeep
