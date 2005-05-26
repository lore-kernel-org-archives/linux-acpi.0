From: Jerry DeLisle <jvdelisle@verizon.net>
Subject: bug report
Date: Wed, 25 May 2005 18:09:35 -0700
Message-ID: <429521CF.4000102@verizon.net>
Reply-To: For users of Fedora Core releases <fedora-list@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <fedora-list-bounces@redhat.com>
List-Unsubscribe: <http://www.redhat.com/mailman/listinfo/fedora-list>,
	<mailto:fedora-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/fedora-list>
List-Post: <mailto:fedora-list@redhat.com>
List-Help: <mailto:fedora-list-request@redhat.com?subject=help>
List-Subscribe: <http://www.redhat.com/mailman/listinfo/fedora-list>,
	<mailto:fedora-list-request@redhat.com?subject=subscribe>
Sender: fedora-list-bounces@redhat.com
Errors-To: fedora-list-bounces@redhat.com
To: acpi-devel@lists.sourceforge.net, Fedora Core List <fedora-list@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Does the following need to be reported?  From dmesg:

     ACPI-1138: *** Error: Method execution failed [\MCTH] (Node 
def2d540), AE_AML_BUFFER_LIMIT
     ACPI-1138: *** Error: Method execution failed [\OSFL] (Node 
def2d4c0), AE_AML_BUFFER_LIMIT
     ACPI-1138: *** Error: Method execution failed [\_SB_.SYSM._CRS] 
(Node dee81ec0), AE_AML_BUFFER_LIMIT
     ACPI-0158: *** Error: Method execution failed [\_SB_.SYSM._CRS] 
(Node dee81ec0), AE_AML_BUFFER_LIMIT
     ACPI-1138: *** Error: Method execution failed [\MCTH] (Node 
def2d540), AE_AML_BUFFER_LIMIT
     ACPI-1138: *** Error: Method execution failed [\OSFL] (Node 
def2d4c0), AE_AML_BUFFER_LIMIT
     ACPI-1138: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.SYSR._CRS] (Node dee811a0), AE_AML_BUFFER_LIMIT
     ACPI-0158: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.SYSR._CRS] (Node dee811a0), AE_AML_BUFFER_LIMIT


[jerry@quantum ~]$ uname -a
Linux quantum.localdomain 2.6.11-1.27_FC3smp #1 SMP Tue May 17 20:43:11 
EDT 2005 i686 i686 i386 GNU/Linux

-- 
fedora-list mailing list
fedora-list@redhat.com
To unsubscribe: http://www.redhat.com/mailman/listinfo/fedora-list
