From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 20:50:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730185039.31876@192.168.4.1>
References: <20020730195149.GI12091@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020730195149.GI12091-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>Okay, if impact is minimal.... I can probably live with that. I still
>do not know if slightly faster suspend is worth the effort.

it's not only slightly faster, it "feels" safer as well not to
rely on userland & selected kernel threads to be the only possible
source of incoming IOs.

>> >Do you have example of such subsystem?
>> 
>> i2c, usb, ieee1394, then all the possibilities of stacking things
>> on top of each other...
>> 
>> >Certainly no driver depends on userspace so we may stop userspace.
>> 
>> Well, I know at least a DSL softmodem driver that relies on userspace
>> (or will soon) as the core softmodem code is moved out of the kernel ;)
>> 
>> >Hardware drivers do not depend on IP stack, etc...
>> 
>> _device_ driver include stacked devices. It includes a scsi-over-IP
>> device if any on which you have perfect right to want to send a command
>> before suspending.
>
>I believe device drivers do not need to know. If you are running
>scsi-over-IP you don't need to inform other side you are
>suspending. It is similar to your NFS server; you don't tell your NFS
>server that you are suspending. scsi-over-IP device should not need to
>know.

Well, SCSI-over-IP is probably not a good example, but you can have
very valid reasons to inform a device over whatever protocol chain
that you are suspending. 

Ben.





-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
