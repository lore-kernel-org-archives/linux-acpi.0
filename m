From: raz ben yehuda <razb@bitband.com>
Subject: Subject: [PATCH 1/2] linux-acpi:  sos documentation
Date: Mon, 15 Sep 2008 13:48:20 +0200
Message-ID: <1221479300.9963.4.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw.bitband.com ([213.8.50.174]:42966 "EHLO mail.bitband.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753053AbYIOLsY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Sep 2008 07:48:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

From: Raz Ben Yehuda <razb@bitband.com>

SOS is a platform aimed to assign a service to an offloaded processor.
see full project  (http://sos-linux.cvs.sourceforge.net/sos-linux/)

Signed-off-by: Raz Ben Yehuda <razb@bitband.com>
---
Documentation/sos.txt |  150 ++++++++++++++++++++++++++++++++++++++++
1 file changed, 150 insertions(+)

diff -urNp vanila/Documentation/sos.txt linux-2.6.26-5-dbg/Documentation/sos.txt
--- vanila/Documentation/sos.txt	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.6.26-5-dbg/Documentation/sos.txt	2008-09-14 17:20:57.000000000 +0200
@@ -0,0 +1,150 @@
+			     Service Oriented 
+				Scheduler 
+
+
+MSC Concluding Assignment 
+
+Document Version: 1.0 
+Author: Raz Ben Yehuda 
+Date: 2/08/2008 
+Open University Israel 
+
+	
+Table of Content 
+
+1. Document Content ......................... 
+2. Background ............................... 
+3. Purpose................................... 
+4. Current Technologies ..................... 
+4.1 CPU sets................................. 
+4.2 IBM Logical partitions .................. 
+4.3 Hardware Solutions ...................... 
+5. PROS......................................
+6. CONS...................................... 
+7. Acknowledgements.......................... 
+8. Sources .................................. 
+9. Deliverables..............................
+
+
+ 
+1. Document Content 
+
+This document is SOS description. A pdf format is found at http://sos-linux.cvs.sourceforge.net/sos-linux/sos/Documentation/.
+
+2. Background 
+
+In today's computer world, we find that most processors have several embedded cores, virtualization hyper-threading. Most programmers do not really use these powerful features and let the operating system do the work. 
+At most, a programmer will bound an application to a certain processor or assign an interrupt to a different processor. At the end, we get system busy in maintaining tasks across processors, balancing interrupts, replacing TLBs and DTLBs, atomic operations and worst of all, spin locks across processors in vein and the more processors the merrier. I argue that in some cases, part of this behavior is due to fact the multiple core operating system is not service oriented but system oriented.  There is no easy way to assign a processor to do a distinct service, undisturbed, accurate, and fast as long as the processor is an active part of an operating system and still be a part of most of the operating system address space. 
+
+3. Purpose 
+
+The purpose of this assignment is to create a platform for services. For example, assume a firewall is being attacked; the Linux operating system will generate endless number of interrupts and softirqs to analyze the traffic just to throw out the bad packets. This is on the expense of "good" packets. Have you ever tried to "ssh" to an attacked machine? 
+What if we can simply do the packet analysis outside the operating system, without interrupts and still fast enough? 
+
+Why not assign a core to do only "firewalling"? Or just routing? Maybe assign it as an ultra accurate timer? Create a delaying service that does not just spin? Perhaps a new type of locking scheme?  New type bottom-halves? Debug a running kernel through an offloaded processor? May assign a GPU to do other things than just graphics? 
+
+Amdahl Law teaches us that linear speed-up is not very feasible [6], so why not spare a processor to do certain tasks better? 
+
+Technologically speaking, This proposal refers to the Linux kernel ability to virtually hot plug a (even a SMT) processor but instead of letting it wonder in endless "halts", assign it a service. 
+
+4. Current Technologies 
+
+The bellow is a comparison of SOS versus other solutions. SOS is a different kind of a beast. 
+
+4.1 CPU sets 
+
+Current common technologies for service oriented systems are Linux CPU sets [3] and Solaris Resource Pool association [5]. Both technologies refer to assigning tasks to a set of processors, probably on the same memory node (in the NUMA case).  
+CPU sets are actually a constraint on a (user space/kernel space) task to use resources available only in its set. CPU sets are used mainly in big systems, appliances, "tailored" to client needs, where performance is an issue. Assigning tasks to a CPU set is done using simple interfaces for constraining memory policies and there's a very small overhead on the programmer (if any). CPU sets are not meant to run RT tasks, do not intend to reduce interrupts over-head and make context switching.
+
+On the contrary SOS is a real time scheduler, SOS May act as a substitute to softirqs and ISR. SOS is serialized in its nature and very accurate. SOS provides contained environment to the service and protects the operating system in some cases. It is much less clear to developers, and has many constraints on the nature of programming. 
+
+In conclusion, both technologies serve different purposes. 
+
+4.2 IBM Logical partitions 
+
+IBM logical partitions are partitioning server resources to several logical units. It is easy to describe Logical partitions by looking how system resources are managed: 
+	Main BUS is shared 
+	Memory and disk Storage may be partitioned. 
+	Partitions communicate by a TCP connection. 
+	partitions may be accessed by consoles. 
+
+The concept of partition does not apply in SOS. All resources are shared but the processor. SOS may be thought as a processor allocation. In SOS, there is no administrator. Each processor has access to some resources in the system, as long as it does not call "schedule", as an offloaded processor is not part of the operating system. The only similarities are that a primary partition may be thought as CPU 0 and if an offloaded processor fails then the system will continue to run as long at the operating system memory is not corrupted. 
+
+4.3 Hardware Solutions 
+    
+   Many hardware solution can be found at US Patents. Here are some: 
+	1. US Patent 5280621 : Personal computer having dedicated processors for peripheral devices 
+	   interconnected to the CPU by way of a system control processor 
+        2. US Patent 5481707 :  Dedicated processor for task I/O and memory management.
+        3. US Patent 6092110 :  Apparatus for filtering packets using a dedicated processor
+
+ SOS is a pure software solution, and there is no restriction over the physical position of an offloaded processor ( SMP or NUMA, same thing).An un-plugged processor may be plugged again and unplugged again. Some solutions actually boot their own kernels, SOS processor uses the running the almost the same kernel CPU 0 is running. SOS is not intended to handle storage.
+
+5. PROS 
+
+  Money 
+    First, it saves money. Why buy expensive offloading cards when you can do with commodity 
+    hardware? 
+
+  Resources 
+    SOS can be assigned to use somewhat esoteric or non-used system resources (SMT) 
+    available in the processor to do some non esoteric tasks. 
+
+  Accuracy 
+    A programmer may rely on the fact that only his code will be run, without disturbance 
+    (offloaded core runs in NMI mode). 
+
+  Security 
+    SOS is designed to assign service to a single resource. This makes the load be contained 
+    inside the SOS. Example for that is a firewall contained inside a single core. 
+
+RAS 
+    Remote Access Services: SOS can be used as remote access server (such as a simple telnet 
+    server) inside the machine but outside the kernel. This can be useful incases for getting 
+    operating statistics and monitoring an offended system. 
+
+Speed-Up 
+    Designed correctly, [4] Amdahl Law for liner processors speedup is truly achievable. 
+
+ 
+Consistency 
+    Offloading a processor has an additional property of being able to determine the amount of 
+    time it will take it to accomplish a task. 
+
+
+6. CONS 
+
+SOS cannot run user space processes. 
+SOS cannot release memory nor allocate one. 
+SOS does not perform context switch. SOS has a single context. 
+SOS is serial. 
+SOS does not support [1] IPI (Inter-processor interrupts), so SOS cannot use vmalloc'd memory. 
+SOS is difficult to use, operate and develop. 
+
+7. Acknowledgements 
+
+Jeff Roberson, who came with this idea of offloading a whole core, and showed me that it is possible. 
+
+
+8. Sources
+ 
+  1. Daniel P.Bovet & Marco Cesati . "Understanding the Linux Kernel". Copyrights 2006 
+       O'Reilly Media Inc. 
+  2. Ulrich Drepper. "What every programmer should know about memory" Red hat INC 
+       Copyrights 2007 
+  3. http://lxr.linux.no/linux+v2.6.26.3/Documentation/cpusets.txt 
+  4. Michal J Flynn. "Computer Architecture PIPELINED AND PARALLEL PROCESSOR 
+       DESIGN" copyrights 1995 by Jones and Bartlett Publishers, Inc. 
+  5. http://docs.sun.com/app/docs/817-1592/gepsd?a=view
+  6. Douglas Eadline .Linux Magazine July 2007, Multi-Core Melee. 
+  7. http://public.boulder.ibm.com/infocenter/iseries/v5r3/index.jsp?topic=/rzait/rzaitprocessor.htm
+
+9. Deliverables 
+
+1. sos timer. ultra accurate timer.
+2. benchmark. Compare sos timer to other linux timers.
+3. rtop.  remote top for too loaded systems. 
+4. sos napi. framework for sos napi ( over e1000 ).
+5. sos firewall with napi.
+6. benchmark. compare machine load when iptbales under dos attack vs sos under dos atttack.
+7. sosirqs

